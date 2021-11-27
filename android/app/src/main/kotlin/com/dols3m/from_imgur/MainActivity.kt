package com.dols3m.from_imgur

import android.util.Log
import android.os.Bundle
import android.content.ClipData
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

import com.dols3m.from_imgur.ImgurProvider

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app.channel.shared.data"
    
    private var allowMultiple = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        allowMultiple = intent.getBooleanExtra("android.intent.extra.ALLOW_MULTIPLE", false)
    }

    override fun getDartEntrypointFunctionName(): String {
        if (allowMultiple) return "initApp";
        return "main";
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler { call, result ->
                Log.d("from_imgur::methodHandler", call.method)
                if (call.method.contentEquals("selectImages")) {
                    result.success(null)
                    respondWithImages(call.argument<ArrayList<String>>("images"))
                }
            }
    }

    fun respondWithImages(images: ArrayList<String>?) {
        Log.d("from_imgur::respondWithImages", images!!.joinToString(","))
        val result = Intent()
        result.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        if (allowMultiple) {
            val uris = images!!.map { image -> ImgurProvider.getUriFromImgurPath(image) }
            val data = ClipData.newRawUri("", uris[0])
            for (i in 1 until uris.size) {
                data.addItem(ClipData.Item(uris[i]))
            }
            result.clipData = data
        } else {
            val uri = ImgurProvider.getUriFromImgurPath(images!![0])
            result.setDataAndType(uri, ImgurProvider.getType(uri))
        }
        setResult(RESULT_OK, result)
        finish()
    }
}

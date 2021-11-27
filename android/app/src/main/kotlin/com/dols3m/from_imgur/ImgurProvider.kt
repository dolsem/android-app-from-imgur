package com.dols3m.from_imgur

import java.io.FileNotFoundException
import android.os.storage.StorageManager
import android.net.Uri
import android.content.ContentProvider
import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.os.*
import android.util.Log
import java.net.URL
import kotlin.math.min

class ImgurProvider: ContentProvider() {
    companion object {
        // Should match android:authorities in the manifest declaration
        const val PROVIDER_ID = "com.dols3m.from_imgur.imgurprovider"

        fun getType(uri: Uri): String? {
            val extension = uri.lastPathSegment?.substringAfterLast('.', "")
            return "image/$extension"
        }

        fun getUriFromImgurPath(imgurPath: String): Uri {
            return Uri.parse("content://$PROVIDER_ID/$imgurPath")
        }
    }

    override fun onCreate(): Boolean {
        return true
    }

    override fun query(
        p0: Uri,
        p1: Array<out String>?,
        p2: String?,
        p3: Array<out String>?,
        p4: String?
    ): Cursor? {
        Log.d("from_imgur::ImgurProvider", "query")
        TODO("Not yet implemented")
    }

    override fun getType(uri: Uri): String? {
        return ImgurProvider.getType(uri)
    }

    override fun insert(p0: Uri, p1: ContentValues?): Uri? {
        Log.d("from_imgur::ImgurProvider", "insert")
        TODO("Not yet implemented")
    }

    override fun delete(p0: Uri, p1: String?, p2: Array<out String>?): Int {
        Log.d("from_imgur::ImgurProvider", "delete")
        TODO("Not yet implemented")
    }

    override fun update(p0: Uri, p1: ContentValues?, p2: String?, p3: Array<out String>?): Int {
        Log.d("from_imgur::ImgurProvider", "update")
        TODO("Not yet implemented")
    }

    @kotlin.Throws(FileNotFoundException::class)
    override fun openFile(uri: Uri, mode: String): ParcelFileDescriptor? {
        // Try to open an asset with the given name.
        try {
            Log.d("from_imgur::ImgurProvider", "openFile")
            val image = URL("https://i.imgur.com/${uri.lastPathSegment}").readBytes()
            Log.i("from_imgur::ImgurProvider", "downloaded file of size ${image.size.toLong()}")
            val callback = object: ProxyFileDescriptorCallback() {
                override fun onGetSize(): Long {
                    Log.d("from_imgur::ImgurProvider", "onGetSize")
                    return image.size.toLong()
                }

                override fun onRead(offset: Long, size: Int, data: ByteArray?): Int {
                    Log.d("from_imgur::ImgurProvider", "onRead with offset: $offset, size: $size")
                    val sizeToCopy = min(image.size - offset.toInt(), size)
                    System.arraycopy(image, offset.toInt(), data, 0, sizeToCopy)
                    return sizeToCopy
                }

                override fun onRelease() {
                    Log.d("from_imgur::ImgurProvider", "onRelease")
                    TODO("Not yet implemented")
                }
            }
            val storageManager = context?.getSystemService(Context.STORAGE_SERVICE) as StorageManager
            val handler = Handler(Looper.getMainLooper())
            return storageManager.openProxyFileDescriptor(ParcelFileDescriptor.MODE_READ_ONLY, callback, handler)
        } catch (e: Throwable) {
            Log.e("from_imgur::ImgurProvider", e.localizedMessage)
            val fnf = FileNotFoundException("Unable to open $uri")
            throw fnf
        }
    }
}

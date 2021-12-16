package com.example.myapplication

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.floatingactionbutton.FloatingActionButton
import io.flutter.embedding.android.FlutterActivity


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener {
           //  Toast.makeText(this,"1".toString(),1.toInt()).show()
            startActivity(FlutterActivity.createDefaultIntent(this))

        }
    }


}
package com.example.myapplication

import android.app.Application
import android.content.Context
import androidx.multidex.MultiDex

/**
 * Created by jsxiaoshui on 2021-12-16
 */
class MyApp :Application() {

    override fun onCreate() {
        super.onCreate()
    }

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}
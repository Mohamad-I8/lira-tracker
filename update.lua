function download_update(download_url)
  update_dlg.dismiss()
  clean_dir = dir:gsub("/$", "")
  parent_dir = clean_dir:match("(.*)/") .. "/"
  save_dir = "/sdcard/Download/Lira_Tracker.zip"  
  Http.download(download_url, save_dir, function(status, data)
    if status == 200 then
      os.execute("rm -r '" .. clean_dir .. "'")
      ZipUtil.unzip(save_dir, parent_dir .. "Lira Tracker")
      dlg.dismiss()
      service.plugin("Lira Tracker", node)
    else
      print("خطأ في التحميل")
    end
  end)  
end


function check_for_updates()
  current_version = release_info.current_version
  
  Http.get(UPDATE_URL, function(status, data)
    if status == 200 then
      online_data = cjson.decode(data)    
      if online_data then
        new_version = online_data.current_version       
        if new_version ~= current_version then
          update_dlg = LuaDialog()
          .setView(loadlayout(show_update_dialog(new_version, online_data.changelog)))
          .show()
          info_container.setBackground(makeRoundedCorners(Color.parseColor("#1E1E1E")))
          cancel_btn.setBackground(makeRoundedCorners(Color.parseColor("#ff1717")))
          download_btn.setBackground(makeRoundedCorners(Color.parseColor("#05423A")))        
        end      
      end
    end
  end)
end

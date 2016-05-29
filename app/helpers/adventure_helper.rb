module AdventureHelper
  def controlJS(advId)
    "<script>
      var advId = ".html_safe + advId.to_s + ";
      var stageNum = 1;
      function loadStage(sNum) {
        var url = \"http://www.cyoa.space/Stage?\";
        url += \"advId=\"+advId;
        url += \"&stageNum=\"+sNum;
        $('#stage_frame').load(url);
      };
      loadStage(stageNum);
    </script>".html_safe
  end
end

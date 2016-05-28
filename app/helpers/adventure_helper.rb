module AdventureHelper
  def sidebar(title, description)
    "<div id=\"Sidebar\">
      <p>".html_safe+title+"</p>
      <p>".html_safe+description+"</p>
    </div>".html_safe
  end
  def controlJS(advId)
    "<script>
      var advId = ".html_safe+advId+";
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

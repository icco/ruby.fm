$(function() {
  $('.directUpload').find("input:file").each(function(i, elem) {
    var fileInput = $(elem);
    var form = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    var formdata = form.attr('data-frm');
    formdata = formdata.slice(1, formdata.length - 1);
    fileInput.after(barContainer);
    fileInput.fileupload({
      fileInput: fileInput,
      type:'POST',
      url: form.attr('data-url'),
      formData: JSON.parse(formdata),
      autoUpload: true,
      paramName: 'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType: 'XML',// S3 returns XML if success_action_status is set to 201
      replaceFileInput: false,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
      },
      start: function (e) {
        submitButton.prop('disabled', true);
        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Uploading ...");
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.text("Uploading done");
        console.log(data.jqXHR.responseXML);

        var key = $(data.jqXHR.responseXML).find("Location").text();

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: key });
        form.append(input);
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.
          css("background", "red").
          text("Failed");
      }
    });
  });
});

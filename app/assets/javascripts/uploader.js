uploadcare.openDialog(null, {
  crop: "disabled",
  imagesOnly: true
}).done(function(file) {
  file.promise().done(function(fileInfo){
    console.log(fileInfo.cdnUrl);
  });
});

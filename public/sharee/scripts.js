$(function() {
  $('.sharee-fb').on('click', function(e) {
    e.preventDefault();
    var url = 'https://www.facebook.com/sharer/sharer.php?u=' + getShareeUrl(this);
    window.open(url,'_blank','width=800,height=300');
  });

  $('.sharee-tw').on('click', function(e) {
    e.preventDefault();
    var url = 'http://twitter.com/share?url=' + getShareeUrl(this) + '&text=Sharing';
    window.open(url,'_blank','width=800,height=300');
  });

  $('.sharee-gp').on('click', function(e) {
    e.preventDefault();
    var url = 'https://plus.google.com/share?url=' + getShareeUrl(this);
    window.open(url,'','menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=400,width=500');
  });

  var getShareeUrl = function(sender) {
    return $(sender).closest('.sharee-button-success-block').find('.sharee-link').val();
  };
});
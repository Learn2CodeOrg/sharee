$(function() {
  $(document).on('click', '.sharee-fb', function(e) {
    e.preventDefault();
    var url = 'https://www.facebook.com/sharer/sharer.php?u=' + getShareeUrl(this);
    window.open(url,'_blank','width=800,height=300');
  });

  $(document).on('click', '.sharee-tw', function(e) {
    e.preventDefault();
    var url = 'http://twitter.com/share?url=' + getShareeUrl(this) + '&text=Sharing';
    window.open(url,'_blank','width=800,height=300');
  });

  $(document).on('click', '.sharee-gp', function(e) {
    e.preventDefault();
    var url = 'https://plus.google.com/share?url=' + getShareeUrl(this);
    window.open(url,'','menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=400,width=500');
  });

  function isEmail(email) {
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(email);
  }

  $('#sharee-submit-email').prop('disabled', true);
  $('#sharee-input-email').keyup(function(){
      if(($(this).val().length != 0) && isEmail($(this).val()))
          $('#sharee-submit-email').prop('disabled', false);
      else
          $('#sharee-submit-email').prop('disabled', true);
  });

  var getShareeUrl = function(sender) {
    return $(sender).closest('.sharee-button-success-block').find('.sharee-link').val();
  };
});
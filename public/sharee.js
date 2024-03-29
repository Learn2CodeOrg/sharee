window.Sharee = (function () {
    'use strict';

    var DEFAULT_LANG = 'en';
    var HOST = 'https://shareeio.herokuapp.com';

    function Sharee() {
        if (!HOST) {
            console.log('Sharee: HOST missing!');
            return false;
        }
        saveCookies();
        getShareeButtons();
        createSellAction();
    }

    Sharee.setHost = function(host) {
        HOST = host;
    };

    Sharee.getHost = function() {
        return HOST;
    };

    Sharee.deleteCookie = function() {
        delete_cookie('sharee');
    }

    var saveCookies = function() {
        var param = QueryString.sharee;
        if (!param) {
            return false;
        }
        var cookie = getCookie('sharee');
        if (cookie) {
            return false;
        }
        document.cookie = 'sharee=' + param + '; expires=Fri, 31 Dec 9999 23:59:59 GMT; path=/';
    };

    var delete_cookie = function(name) {
        document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    };

    var getShareeButtons = function() {
        var $buttons = $('.sharee-button');

        $buttons.each(function (index, button) {
          var $button    = $(button);
          var campaign   = $button.data('campaign');
          var commission = $button.data('commission');
          var lang       = $button.data('lang') || DEFAULT_LANG;
          var buttonUrl  = Sharee.getHost() + '/sharee/btn_' + lang + '.html';
          var logoUrl    = Sharee.getHost() + '/sharee/btn_' + lang + '.svg';

          $.get(buttonUrl, function(data) {
            $button.html(data);
            $button.find('input[name="campaign"]').val(campaign);
            $button.find('.sharee-commission').text(commission);
            $button.find('.sharee-logo').attr('src', logoUrl);

            initShareeButtonClickEvent();
            initShareeButtonFormsEvents(button);
          });
        });
        
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

        $( document ).ready(function() {
            $('#sharee-submit-email').prop('disabled', true);
        });

        $('.sharee-button').on('input', '#sharee-input-email', function(){
            if(($(this).val().length != 0) && isEmail($(this).val()))
                $('#sharee-submit-email').prop('disabled', false);
            else
                $('#sharee-submit-email').prop('disabled', true);
        });

        var getShareeUrl = function(sender) {
            return $(sender).closest('.sharee-button-success-block').find('.sharee-link').val();
        };
        
        appendStyles();
    };

    var appendStyles = function() {
      var head = getDocumentHead();
      var filename = Sharee.getHost() + "/sharee/styles.css";
      $(head).append("<link rel='stylesheet' id='sharee-css' href='" + filename + "' type='text/css' />");
    };

    var getDocumentHead = function() {
      return document.getElementsByTagName('HEAD').item(0);
    };

    var initShareeButtonClickEvent = function() {
        $('.sharee-button-core').on('click', function() {
            $('.sharee-button-form').toggle();
        });
    };

    var initShareeButtonFormsEvents = function(button) {
        $(button).find('.sharee-button-form').on('submit', function(event) {
            event.preventDefault();
            console.log('Clicked on submit button!');

            var $form      = $(event.target);
            var campaign   = $form.find("input[name='campaign']").val();
            var email      = $form.find("input[name='email']").val();
            var sharingUrl = getSharingUrl();
            var actionUrl  = Sharee.getHost() + '/api/v1/links';

            var posting = $.post(actionUrl, {
                campaign: campaign,
                url: sharingUrl,
                email: email
            });

            posting.done(function(data) {
                var specialUrl = data.special_url;

                $(button).find('.sharee-button-form').hide();
                $(button).find('.sharee-button-success-block').show().find(".sharee-link").val(specialUrl).select();
            });
        });

        $('.js-sharee-close').on('click', function(event) {
            $('.sharee-button-form').hide();
            $('.sharee-button-success-block').hide();
            return false;
        });

        var getUrl = function() {
          return document.URL;
        };

        var getSharingUrl = function() {
            var url = getUrl();
            var sharing_url = url;

            var index = url.indexOf('?sharee');
            if (index > 0) {
                sharing_url = url.substring(0, url.indexOf('?sharee'));
            }

            index = url.indexOf('&sharee');
            if (index > 0) {
                sharing_url = url.substring(0, url.indexOf('&sharee'));
            }

            return sharing_url;
        }

        $('.sharee-back-button').on('click', function(event) {
            event.preventDefault();
            console.log('Clicked on back button!');
            var $block = $(this).closest('.sharee-button-block');
            $block.find('.sharee-button-form').show();
            $block.find('.sharee-button-success-block').hide();
        });
    };

    var createSellAction = function() {
        var $shareeThank = $(document).find('.sharee-thank');
        if ($shareeThank.length === 0) {
            return false;
        }

        var link = getCookie('sharee');
        if (link === "") {
            return false;
        }
        var code = $shareeThank.data('code');
        var email = $shareeThank.data('email');
        var price = $shareeThank.data('price');

        var posting = $.post(Sharee.getHost() + '/api/v1/sell_actions', {
            link: link,
            code: code,
            email: email,
            price: price
        });

        posting.done(function(data) {
            console.log(data);
        });
    };

    var QueryString = function () {
        // This function is anonymous, is executed immediately and
        // the return value is assigned to QueryString!
        var query_string = {};
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            // If first entry with this name
            if (typeof query_string[pair[0]] === "undefined") {
                query_string[pair[0]] = pair[1];
                // If second entry with this name
            } else if (typeof query_string[pair[0]] === "string") {
                var arr = [ query_string[pair[0]], pair[1] ];
                query_string[pair[0]] = arr;
                // If third or later entry with this name
            } else {
                query_string[pair[0]].push(pair[1]);
            }
        }
        return query_string;
    } ();

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i=0; i<ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1);
            if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
        }
        return "";
    }

    return Sharee;
})();

var ready = function() {
    new Sharee();
};

$(document).ready(ready);
$(document).on('page:load', ready);

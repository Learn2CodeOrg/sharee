$(function() {
    var ready = function() {
        new Sharee();
    };

    $(document).ready(ready);
    $(document).on('page:load', ready);
});

window.Sharee = (function () {
    'use strict';

    function Sharee() {
        saveCookies();
        getShareeButtonHtml();
        initShareeButtonFormsEvents();
        createSellAction();
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

    var getShareeButtonHtml = function() {
        $.get('http://localhost:3000/sharee_button.html', function(data) {
            $('.sharee-button').html(data);

            initShareeButtonClickEvent();
            initShareeButtonFormsEvents();
        });
    };

    var initShareeButtonClickEvent = function() {
        $('.sharee-button-core').on('click', function() {
            console.log('Clicked on button!');
            $(this).hide();
            $('.sharee-button-form').show();
        });
    };

    var initShareeButtonFormsEvents = function() {
        $('.sharee-button-form').on('submit', function(event) {
            event.preventDefault();
            console.log('Clicked on submit button!');

            var $form = $(event.target),
                actionUrl = $form.attr('action'),
                email = $form.find("input[name='email']").val();

            var url = getUrl();
            var sharing_url = getSharingUrl();

            console.log('URL: ' + url);
            console.log('Sharing URL: ' + sharing_url);

            var posting = $.post(actionUrl, {
                url: sharing_url,
                email: email
            });

            posting.done(function( data ) {
                console.log(data);
                $('.sharee-button-form').hide();
                $('.sharee-button-success-block').show().find(".url").text(data.special_url);
            });
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

        $('.back-button').on('click', function(event) {
            event.preventDefault();
            console.log('Clicked on back button!');
            var $block = $(this).closest('.sharee-button-block');
            $block.find('.sharee-button-core').show();
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

        var posting = $.post('http://localhost:3000/api/v1/sell_actions', {
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

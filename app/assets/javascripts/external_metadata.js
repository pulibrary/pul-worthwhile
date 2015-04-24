Blacklight.onLoad(function(){
  
  //Finds any pul id fields that reference external metadata 
  // and instantiates jQuery plugin for each
  $("*[data-validate='pul_identifier']").each(function(i,val){
    $(val).externalMetadata();
  });
});

;(function ( $, window, document, undefined ) {
  /*
    jQuery plugin to preview PUL external metadata

      Usage: $(selector).externalMetadata();

    No available options

    preview_path: base path of the preview
    confirm_msg: confirmation string presented to user for

    This plugin :
      - verifies the id supplied fits a PUL pattern
      - fetches a copy of the external metadata for the ID
      - if the id is not found user is warned
      - parses the response and provides a preview of the metadata
      - to the operator for review. 
  */

    var pluginName = "externalMetadata";

    function Plugin( element, options ) {
        this.element = element;
        this.options = $.extend( {
          preview_path: "/metadata/",
          confirm_msg: "Is this the record you want?"
        }, options);
        this._name = pluginName;
        this.init();
    }

    Plugin.prototype = {
      init: function() {
        var opts = this.options;
        this.fetchMetadata(this.element, this.options);
      },

      // fire this after a 1 second delay on typing in the field 
      fetchMetadata: function(el, options) {
        $(el).keypress( _.debounce(function () {
          var id = $(el).val();
          var alert_label = "bg-info";
          var close_alert = '<button type="button" data-dismiss="alert" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>';

          $.getJSON(options.preview_path+id, function(data) {
            if (data.error) {
              alert_label = "bg-warning";
              var alert = "<p class='alert " + alert_label + "'>" + data.error + close_alert + "</p>";
              $("div.flash_messages").html(alert);
              return;
            }
            if (data === null){
              alert_label = "bg-warning";
              var alert = "<p class='alert " + alert_label + "'>ID Does Not Exist" + close_alert + "</p>";
              $("div.flash_messages").html(alert);
              return;
            }
            var heading = options.confirm_msg + '<br/>';
            var field_list = "<ul>";
            _.each(data.fields, function(value, key) {
              field_list = field_list + "<li>" + key + ":" + value + "</li>";  
            });
            var field_list = field_list + "</ul>";
            var alert = "<p class='alert " + alert_label + "'>" + heading + id + data.source + field_list + close_alert + "</p>";
            $("div.flash_messages").html(alert);
          });
        }, 1000));
      }
    };

    

    // A really lightweight plugin wrapper around the constructor,
    // preventing against multiple instantiations
    $.fn[pluginName] = function ( options ) {
        return this.each(function () {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName,
                new Plugin( this, options ));
            }
        });
    };

})( jQuery, window, document );
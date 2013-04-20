dojo.require("esri.map");
dojo.require("esri.dijit.Geocoder");
dojo.require("dojox.widget.ColorPicker");

var map, geocoder;

function init() {
    map = new esri.Map("map",{
        basemap:"topo",
        center:[-122.45,37.75], //long, lat
        zoom:13,
        sliderStyle:"small"
    });

    geocoder = new esri.dijit.Geocoder({
        map: map
    }, "search");
    geocoder.startup();

    dojo.connect(map, "onLoad", afterMapLoad);
};


function afterMapLoad(){
    var points = [[-122.45,37.75],[-122.45955,37.7511]];
    var iconPath = "M14.615,4.928c0.487-0.986,1.284-0.986,1.771,0l2.249,4.554c0.486,0.986,1.775,1.923,2.864,2.081l5.024,0.73c1.089,0.158,1.335,0.916,0.547,1.684l-3.636,3.544c-0.788,0.769-1.28,2.283-1.095,3.368l0.859,5.004c0.186,1.085-0.459,1.553-1.433,1.041l-4.495-2.363c-0.974-0.512-2.567-0.512-3.541,0l-4.495,2.363c-0.974,0.512-1.618,0.044-1.432-1.041l0.858-5.004c0.186-1.085-0.307-2.6-1.094-3.368L3.93,13.977c-0.788-0.768-0.542-1.525,0.547-1.684l5.026-0.73c1.088-0.158,2.377-1.095,2.864-2.081L14.615,4.928z";
    var initColor = "#326ADA";
    points.forEach(function(point){
        var graphic = new esri.Graphic(new esri.geometry.Point(point), createSymbol(iconPath, initColor));
        map.graphics.add(graphic);
    });
    
    var colorPicker = new dojox.widget.ColorPicker({}, "picker1");
    colorPicker.setColor(initColor);
    dojo.style(colorPicker, "left", "500px")
    dojo.connect(colorPicker, "onChange", function(){
        var colorCode = this.hexCode.value;
        map.graphics.graphics.forEach(function(graphic){
            graphic.setSymbol(createSymbol(iconPath, colorCode));
        });
    });
};

function createSymbol(path, color){
    var markerSymbol = new esri.symbol.SimpleMarkerSymbol();
    markerSymbol.setPath(path);
    markerSymbol.setColor(new dojo.Color(color));
    markerSymbol.setOutline(null);
    return markerSymbol;
};

dojo.ready(init);
$(function () {
    $("#search_form").submit(function() {
        $.ajax({
            url: $(this).attr("action"),
            success: function(data) {
                console.log(data);
            }
        });
        return false;
    });
});

(function($){
	$(document).ready(function(){
		//establish socket
		var loc = window.location, new_uri;
		if (loc.protocol === "https:") {
			new_uri = "wss:";
		} else {
			new_uri = "ws:";
		}
		new_uri += "//" + loc.host;
		new_uri += "/ws/test-socket";
		var exampleSocket = new WebSocket(new_uri);
		
		var mainCommunicationWS = function(){
			var _getInfo = function(){
				
			};
			return {
				getInfo : _getInfo
			}
		};
		
		var generalCallBack = function(data){
			console.log(data);
		}
		var safeGet =  function(data, cat, name){
			return data && data[cat] ? data[cat][name] : undefined;
		}
			
		function infoModel(init) {
			
			var _tempCO = ko.observable(safeGet(init, 'info', 'tempCO'));
			var _tempCWO = ko.observable(safeGet(init, 'info', 'tempCWO'));
			var _tempPowietrza = ko.observable(safeGet(init, 'info', 'tempPowietrza'));
			var _zasobnik = ko.observable(safeGet(init, 'info', 'zasobnik'));
			var _zasobnikMax = ko.observable(safeGet(init, 'info', 'zasobnikMax'));
			var _trybPieca = ko.observable(safeGet(init, 'info', 'trybPieca'))
			var _zasobnikPctg = ko.computed(function(){
				return Math.round((_zasobnik() / _zasobnikMax())*10000) / 100 + '%'
			}, this);
			
			var _load = function(dataToLoad){
				_tempCO(safeGet(dataToLoad, 'info', 'tempCO'));
				_tempCWO(safeGet(dataToLoad, 'info', 'tempCWO'));
				_tempPowietrza(safeGet(dataToLoad, 'info', 'tempPowietrza'));
				_zasobnik(safeGet(dataToLoad, 'info', 'zasobnik'));
				_zasobnikMax(safeGet(dataToLoad, 'info', 'zasobnikMax'));
				_trybPieca(safeGet(dataToLoad, 'info', 'trybPieca'))
			}
			
			return {
					tempCO : _tempCO,
					tempCWO : _tempCWO,
					tempPowietrza : _tempPowietrza,
					zasobnik : _zasobnik,
					zasobnikMax : _zasobnikMax,
					zasobnikPctg : _zasobnikPctg,
					trybPieca : _trybPieca,
					//actions
					load : _load
			}
		}
		
		function ustawieniaModelPiec(init){
			var _piecZadana 		= ko.observable(safeGet(init, 'ustawieniaPiec', 'piecZadana'));
			var _piecZadanaNowa 	= ko.observable(safeGet(init, 'ustawieniaPiec', 'piecZadana'));
			var _piecZadzialanie 	= ko.observable(safeGet(init, 'ustawieniaPiec', 'piecZadzialanie'));
			var _piecZadzialanieNowa= ko.observable(safeGet(init, 'ustawieniaPiec', 'piecZadzialanie'));
			var _grzaniePodawanie	= ko.observable(safeGet(init, 'ustawieniaPiec', 'grzaniePodawanie'));
			var _grzaniePodawanieNowa	= ko.observable(safeGet(init, 'ustawieniaPiec', 'grzaniePodawanie'));
			var _grzaniePrzerwa		= ko.observable(safeGet(init, 'ustawieniaPiec', 'grzaniePrzerwa'));
			var _grzaniePrzerwaNowa		= ko.observable(safeGet(init, 'ustawieniaPiec', 'grzaniePrzerwa'));
			var _podtrzymaniePodawanie		= ko.observable(safeGet(init, 'ustawieniaPiec', 'podtrzymaniePodawanie'));
			var _podtrzymaniePodawanieNowa		= ko.observable(safeGet(init, 'ustawieniaPiec', 'podtrzymaniePodawanie'));
			var _podtrzymaniePrzerwa		= ko.observable(safeGet(init, 'ustawieniaPiec', 'podtrzymaniePrzerwa'));
			var _podtrzymaniePrzerwaNowa		= ko.observable(safeGet(init, 'ustawieniaPiec', 'podtrzymaniePrzerwa'));
			var _save = function(){
				var toSend  = {
					ustawieniaPiec:{
						piecZadana : _piecZadanaNowa(),
						piecZadzialanie : _piecZadzialanieNowa(),
						grzaniePodawanie : _grzaniePodawanieNowa(),
						grzaniePrzerwa : _grzaniePrzerwaNowa(),
						podtrzymaniePodawanie : _podtrzymaniePodawanieNowa(),
						podtrzymaniePrzerwa : _podtrzymaniePrzerwaNowa()
					}
				}
				$.post('/web/cp-save', toSend, generalCallBack);
			};
			
			var _load = function(dataToLoad){
				_piecZadana 		(safeGet(dataToLoad, 'ustawieniaPiec', 'piecZadana'));	
				_piecZadzialanie 	(safeGet(dataToLoad, 'ustawieniaPiec', 'piecZadzialanie'));
				_grzaniePodawanie	(safeGet(dataToLoad, 'ustawieniaPiec', 'grzaniePodawanie'));
				_grzaniePrzerwa		(safeGet(dataToLoad, 'ustawieniaPiec', 'grzaniePrzerwa'));
				_podtrzymaniePodawanie		(safeGet(dataToLoad, 'ustawieniaPiec', 'podtrzymaniePodawanie'));
				_podtrzymaniePrzerwa		(safeGet(dataToLoad, 'ustawieniaPiec', 'podtrzymaniePrzerwa'));
			};
			
			var _loadAll = function(dataToLoad){
				_piecZadana 		(safeGet(dataToLoad, 'ustawieniaPiec', 'piecZadana'));
				_piecZadanaNowa 	(safeGet(dataToLoad, 'ustawieniaPiec', 'piecZadana'));
				_piecZadzialanie 	(safeGet(dataToLoad, 'ustawieniaPiec', 'piecZadzialanie'));
				_piecZadzialanieNowa(safeGet(dataToLoad, 'ustawieniaPiec', 'piecZadzialanie'));

				_grzaniePodawanie	(safeGet(dataToLoad, 'ustawieniaPiec', 'grzaniePodawanie'));
				_grzaniePodawanieNowa(safeGet(dataToLoad, 'ustawieniaPiec', 'grzaniePodawanie'));

				_grzaniePrzerwa		(safeGet(dataToLoad, 'ustawieniaPiec', 'grzaniePrzerwa'));
				_grzaniePrzerwaNowa	(safeGet(dataToLoad, 'ustawieniaPiec', 'grzaniePrzerwa'));

				_podtrzymaniePodawanie		(safeGet(dataToLoad, 'ustawieniaPiec', 'podtrzymaniePodawanie'));
				_podtrzymaniePodawanieNowa	(safeGet(dataToLoad, 'ustawieniaPiec', 'podtrzymaniePodawanie'));

				_podtrzymaniePrzerwa		(safeGet(dataToLoad, 'ustawieniaPiec', 'podtrzymaniePrzerwa'));
				_podtrzymaniePrzerwaNowa	(safeGet(dataToLoad, 'ustawieniaPiec', 'podtrzymaniePrzerwa'));
			}
			return {
				piecZadana : _piecZadana,
				piecZadanaNowa : _piecZadanaNowa,
				piecZadzialanie : _piecZadzialanie,
				piecZadzialanieNowa : _piecZadzialanieNowa,
				grzaniePodawanie : _grzaniePodawanie,
				grzaniePodawanieNowa : _grzaniePodawanieNowa,
				grzaniePrzerwa : _grzaniePrzerwa,
				grzaniePrzerwaNowa : _grzaniePrzerwaNowa,
				podtrzymaniePodawanie : _podtrzymaniePodawanie,
				podtrzymaniePodawanieNowa : _podtrzymaniePodawanieNowa,
				podtrzymaniePrzerwa : _podtrzymaniePrzerwa,
				podtrzymaniePrzerwaNowa : _podtrzymaniePrzerwaNowa,
				save : _save,
				load : _load
			}
		}
		
		function ustawieniaModelBoiler(init){
			var	_tryb 	=	ko.observable(safeGet(init, 'ustawieniaBoiler', 'tryb '));
			var	_boilerZadana	=	ko.observable(safeGet(init, 'ustawieniaBoiler', 'boilerZadana'));
			var	_boilerZadanaNowa	=	ko.observable(safeGet(init, 'ustawieniaBoiler', 'boilerZadana'));
			var	_boilerZadzialanie	=	ko.observable(safeGet(init, 'ustawieniaBoiler', 'boilerZadzialanie'));
			var	_boilerZadzialanieNowa	=	ko.observable(safeGet(init, 'ustawieniaBoiler', 'boilerZadzialanie'));
			
			var _loadAll = function(dataToLoad){
				_tryb (safeGet(dataToLoad, 'ustawieniaBoiler', 'tryb '));
				_boilerZadana(safeGet(dataToLoad, 'ustawieniaBoiler', 'boilerZadana'));
				_boilerZadanaNowa(safeGet(dataToLoad, 'ustawieniaBoiler', 'boilerZadanaNowa'));
				_boilerZadzialanie(safeGet(dataToLoad, 'ustawieniaBoiler', 'boilerZadzialanie'));
				_boilerZadzialanieNowa(safeGet(dataToLoad, 'ustawieniaBoiler', 'boilerZadzialanieNowa'));
			}
			var _load = function(dataToLoad){
				_tryb (safeGet(dataToLoad, 'ustawieniaBoiler', 'tryb '));
				_boilerZadana(safeGet(dataToLoad, 'ustawieniaBoiler', 'boilerZadana'));
				_boilerZadzialanie(safeGet(dataToLoad, 'ustawieniaBoiler', 'boilerZadzialanie'));
			}
			var _save = function(){
				var toSave = {
					"msgtype":"save-boiler",
					ustawieniaBoiler:{
						boilerZadana : _boilerZadanaNowa(),
						boilerZadzialanie : _boilerZadzialanieNowa()
					}
				};
				exampleSocket.send(JSON.stringify(toSave));
			}
			return {
				tryb 	:	_tryb 	,
				boilerZadana	:	_boilerZadana	,
				boilerZadanaNowa	:	_boilerZadanaNowa	,
				boilerZadzialanie	:	_boilerZadzialanie	,
				boilerZadzialanieNowa	:	_boilerZadzialanieNowa	,
				
				//actions
				load : _load,
				save : _save
			}
		}
		
		function ustawieniaModelOgrzewanie(init){
			var _tryb  = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'tryb '));
			var _ogrzewanieZadana = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'ogrzewanieZadana'));
			var _ogrzewanieZadanaNowa = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'ogrzewanieZadana'));
			var _ogrzewanieZadzialanie = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'ogrzewanieZadzialanie'));
			var _ogrzewanieZadzialanieNowa = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'ogrzewanieZadzialanie'));
			var _ogrzewanieMinimum = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'ogrzewanieMinimum'));
			var _ogrzewanieMinimumNowa = ko.observable(safeGet(init, 'ustawieniaOgrzewanie', 'ogrzewanieMinimum'));

			var _loadAll = function(dataToLoad){
				_tryb (safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'tryb '));
				_ogrzewanieZadana(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieZadana'));
				_ogrzewanieZadanaNowa(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieZadanaNowa'));
				_ogrzewanieZadzialanie(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieZadzialanie'));
				_ogrzewanieZadzialanieNowa(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieZadzialanieNowa'));
				_ogrzewanieMinimum(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieMinimum'));
				_ogrzewanieMinimumNowa(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieMinimumNowa'));
			};
			
			var _load = function(dataToLoad){
				_tryb (safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'tryb '));
				_ogrzewanieZadana(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieZadana'));
				_ogrzewanieZadzialanie(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieZadzialanie'));
				_ogrzewanieMinimum(safeGet(dataToLoad, 'ustawieniaOgrzewanie', 'ogrzewanieMinimum'));
			};
			var _save = function(){
				var toSave = {
					"msgtype":"save-ogrzewanie",
					ustawieniaOgrzewanie:{
						ogrzewanieZadana : _ogrzewanieZadanaNowa(),
						ogrzewanieZadzialanie : _ogrzewanieZadzialanieNowa(),
						ogrzewanieMinimum : _ogrzewanieMinimumNowa(),
					}
				};
				exampleSocket.send(JSON.stringify(toSave));
			}
			
			return {
				tryb  : _tryb  ,
				ogrzewanieZadana : _ogrzewanieZadana ,
				ogrzewanieZadanaNowa : _ogrzewanieZadanaNowa ,
				ogrzewanieZadzialanie : _ogrzewanieZadzialanie ,
				ogrzewanieZadzialanieNowa : _ogrzewanieZadzialanieNowa ,
				ogrzewanieMinimum : _ogrzewanieMinimum ,
				ogrzewanieMinimumNowa : _ogrzewanieMinimumNowa,
				//actions
				load : _load,
				save : _save
			}
		}
		
		jQuery.get('/web/cp-read',function(recieve){
			var im = new infoModel(recieve);
			var ump = new ustawieniaModelPiec(recieve)
			var umo = new ustawieniaModelOgrzewanie(recieve)
			var umb = new ustawieniaModelBoiler(recieve)
			
			ko.applyBindings(im, $('#info')[0] );
			ko.applyBindings(ump, $('#ustawieniaPiec')[0] );
			ko.applyBindings(umo, $('#ustawieniaOgrzewanie')[0] );
			ko.applyBindings(umb, $('#ustawieniaBoiler')[0] );
			
			exampleSocket.onmessage = function(msg){
				console.log(msg['data']);
				var unwrapped = JSON.parse(msg['data']);
				console.log(unwrapped);
				
				if(unwrapped['msgtype'] === "status-update"){
					im.load(unwrapped)
					ump.load(unwrapped)
					umo.load(unwrapped)
					umb.load(unwrapped)
				}else if(unwrapped['msgtype'] === "success-response"){
					exampleSocket.send('{"msgtype":"get-info"}');
				}else if(unwrapped['msgtype'] === "error-response"){
					exampleSocket.send('{"msgtype":"get-info"}');
				}
			}
			exampleSocket.onopen  = function(){			
				var update = function(){
					exampleSocket.send('{"msgtype":"get-info"}');
					setTimeout(update, 30000);
				}
				update();
			}
			
		});
	 });
})(jQuery);
`use strict`
// function searchZip() {
const https = require('https');
var request = require('request');

var zipcode = process.argv[2];
var options = {
    url: 'http://zipcloud.ibsnet.co.jp/api/search?zipcode='+zipcode+'&callback=writeAddressByZipcloud',
    method: 'GET',
    json: true
}

request(options, function(error, response, body){
console.log(body);
})
// }

// document.write('<button type="button" class="zipcloud_search" onclick="searchAddressByZipcloud();">郵便番号から住所を検索</button>');

function writeAddressByZipcloud(response) {
	// 検索中の表示を消去
	var element = document.getElementById('address');
	element.value = '';
	// エラー発生時は、アラートを出して終了
	if(response.status != 200) {
		alert(response.message);
		return false;
	}
	// 検索結果がなかった場合も、アラートを出して終了
	if(!response.results) {
		alert('該当する住所が見つかりませんでした');
		return false;
	}
	// 住所文字列の作成
	var address = response.results[0].address1 + response.results[0].address2;
	// 結果が１つの場合は、町域名まで含める
	if(response.results.length == 1) {
		address += response.results[0].address3;
	}
	element.value = address;
};
<?php
	require_once('info.php');

	// ---------------- パラメーターの取得 ---------------
	$lang	= $_GET['lang'];
	$n			= $_GET['n'];
	$epi		= $_GET['epi'];

	if( !isset( $lang ) || $lang == '' || $lang <> 'ja' && $lang <> 'en' ) {
		$lang = 'ja';
	}
	if( $n > 12 || $epi > 127) {
		$n = "";
		$epi = "";
	}

	if( $n <> '' && $epi == '' ) {
		reset( $episodes[$lang][$n] );
		$epi = key( $episodes[$lang][$n] );
		$_GET['epi'] = $epi;
	}

	if( !isset($n) || $n === '' ) {
		$mode = "HOME";
	} else {
		$mode = "CONTENT";
		$temp = $n + 1;
		$sitedescription	= array(
			'ja' => '1,400万部を売り上げた名作「'.$comic_title["ja"].'」の第'.$temp.'巻（'.$epi.'話目）を無料で読むことができます。'
			, 'en' => 'Vol.'.$temp.'（# '.$epi.'）of JAPANESE MANGA「'.$comic_title["en"].'」is Free!!'
		);
	}
	
	// ---------------  初期設定  ----------------
	if ( isset($_SERVER['HTTPS']) and $_SERVER['HTTPS'] == 'on' ) {
	    $protocol = 'https://';  
	} else {
	    $protocol = 'http://';  
	}
	$selfUrl	= $protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	// 例：http://dev.ontheroad.jp/special/blackjack/index.php?n=0&epi=5&lang=ja
	// アンカー（#）は取れない

	$rootUrl	= $protocol.$_SERVER['HTTP_HOST'];
	// 例：http://dev.ontheroad.jp

//	$baseUrl	= str_replace( '/index.php', '', $protocol.$_SERVER['HTTP_HOST'].$_SERVER['SCRIPT_NAME'] );
	$baseUrl	= $rootUrl.'/special/blackjack';
	// 例：http://dev.ontheroad.jp/special/blackjack

	$contentsUrl	= $baseUrl.'/contents/'.$lang;

	// ---------------  functions.php の読み込み  ----------------
	require_once('functions.php');

	// ---------------  Cookie の処理  ----------------
/*	
	if ( $lstrackingUrl <> '' ) {
		setcookie( "lstrackingUrl", $lstrackingUrl, time()+60*60*24*365 );
	} else if( $lstrackingUrl == '' && $_COOKIE['lstrackingUrl'] ) {
		$lstrackingUrl = $_COOKIE['lstrackingUrl'];
	}
*/
?>

<!-- ------------------ HTMLここから ------------------------ -->
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">



<?php 
	switch($mode) {
		case 'HOME': ?>
			<title><?= $sitename[$lang] ?></title>
			<link rel="canonical" href="<?php echo $baseUrl ?>/index.php?lang=<?php echo $lang?>" />
		<?php	break;
		case 'CONTENT': ?>
			<title><?php echo get_volume_presentation($lang, $n) ?>（#<?php echo $epi  ?>）::<?= $sitename[$lang] ?></title>
			<link rel="canonical" href="<?php echo $baseUrl ?>/index.php?lang=<?php echo $lang?>&n=<?php echo $n ?>&epi=<?php echo $epi ?>" />
		<?php	break;
		default ?>
			<title><?= $sitename[$lang] ?></title>
		<?php
	}
?>
<meta name="description" content="<?php echo $sitedescription[$lang] ?>">
<meta name="keywords" content="<?php echo $site_keywords[$lang ]?>">
<!-- ----------------------- CSS ---------------------------- -->
<link rel="stylesheet" type="text/css" href="<?php echo $baseUrl ?>/style.css" />
<!-- -------------------- JavaScript ------------------------ -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="./lib/header_fixed_navi.js"></script>
<script type="text/javascript" src="./lib/content_page_navigator.js"></script>

<script type="text/javascript" src="./lib/smoothscroll.js"></script>

<script src="lib/masonry.pkgd.min.js"></script>
<script src="lib/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript">
$('.panels').imagesLoaded( function() {
	$('.panels').masonry( {
		itemSelector: '.panel',
		isFitWidth: true,
		isAnimated: true
	} );
} );
</script>

<!-- ------------------------- OGP ------------------------- -->
<meta property="og:title" content="<?php echo htmlspecialchars( $sitename[$lang] ) ?>" />
<meta property="og:type" content="book" />
<meta property="og:url" content="<?php echo $baseUrl.'/index.php?lang='.$lang ?>" />
<meta property="og:image" content="<?php echo $contentsUrl ?>/1/cover_1_300.jpg" />
<meta property="og:site_name" content="<?php echo htmlspecialchars( $sitename[$lang] ) ?>" />
<meta property="og:description" content="<?php echo htmlspecialchars( $description[$lang] ) ?>" />
<meta property="fb:app_id" content="171242856322655" />
<meta property="fb:admins" content="100002003889575" />
<!-- ------------------- Google Analitics ------------------ -->
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-29132526-1']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
<!-- ------------------- HTML（Body） ---------------------- -->
</head><body id="pagetop">
<!-- ------------ facebook for social plug-in -------------- -->
<?php
	if( $lang == 'en' ) {
		// 英語の処理
		$fb_lang = 'en_US';
	} else {
		// 日本語の処理
		$fb_lang = 'ja_JP';
	}
?>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
　js.async = true;
  js.src = "//connect.facebook.net/<?php echo $fb_lang ?>/all.js#xfbml=1&appId=171242856322655";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
<!-- -------------------- ヘッダ --------------------------- -->
<h1 style="margin:0; padding:0;font-size:18px">
	<a href="<?= $baseUrl ?>/index.php?lang=<?= $lang ?>">
		<span><img src="<?php echo $rootUrl ?>/special/blackjack/img/logo_books.png" style="vertical-align:middle"/></span><?= $sitename[$lang] ?>
	</a>

	<span class="nav">
		<?php // include('include/social_buttons.php'); ?>
	</span><!-- end of .nav -->

</h1>
<div style="clear:both"></div>
<!-- ----------------- メニューバー ----------------------- -->
<form method="get" action="<?php echo $baseUrl.'/index.php' ?>">
	<div style="background:#000">
		<select name="n" class="searchinput">
			<?php 
				for( $i=0; $i<count($episodes[$lang]); $i++ ) {
					echo getSelectValue( $n, $i, get_volume_presentation( $lang, $i ) );
				}
			?>
		</select>

		<input type="hidden" name="lang" value="<?php echo $lang ?>" />
		<input type="hidden" name="epi" value="<?php echo get_first_epi( $lang, $n ) ?>" />
		<input type="submit" value="GO" />

		<span class="lang_switcher">
			<?php if( $lang === 'ja' ) { ?>
				<img src="<?php echo $baseUrl.'/img/jp.gif' ?>" style="vertical-align:middle" />日本語 | 
				<img src="<?php echo $baseUrl.'/img/us.gif' ?>" style="vertical-align:middle" />
				<a href="<?php echo $baseUrl.'/index.php?n='.$n.'&epi='.$epi.'&lang=en' ?>">英語</a>
			<?php } elseif( $lang === 'en' ) { ?>
				<img src="<?php echo $baseUrl.'/img/jp.gif' ?>" style="vertical-align:middle" />
				<a href="<?php echo $baseUrl.'/index.php?n='.$n.'&epi='.$epi.'&lang=ja' ?>">Japanese</a> | 
				<img src="<?php echo $baseUrl.'/img/us.gif' ?>" style="vertical-align:middle" />English
			<?php } ?>
		</span>
	</div>
</form>
<!-- ----------------- コンテンツ ----------------------- -->
<div id="wrapper">

	<!-- トップバナー -->
	<?php if( $mode == 'HOME' ) { ?>
	<?php } else if( $mode == 'CONTENT' ) { ?>
	<?php } ?>
	<br />

	<div id="content">
	<?php 
		switch( $mode ) { 
			case 'HOME':	//----------------------------------------------------------
				include('view_home.php');
				break;

			case 'CONTENT':	//----------------------------------------------------------
				include('view_content.php');
				break;

			default:		//----------------------------------------------------------
		}
		$ancher = substr( strpos( $selfUrl, '#' ), strlen( $selfUrl ) );
	//	$ancher = stristr( $selfUrl, '#' );
		echo $ancher.'<br>';

		$current_page = stristr( $ancher, 'page_' );
		echo $current_page.'<br>';
	?>
		<p id="page-top"><a href="#pagetop">PAGE TOP</a></p>
	</div><!-- end of #content -->

	<div id="sidebar">
	<?php
		if( $lang === 'ja' ) {
			$label_to_toppage = 'トップページ';
		} else if( $lang === 'en' ) {
			$label_to_toppage = 'HOME';
		}
	?>

	<h3>
		<span><img width="20" src="<?php echo $rootUrl ?>/special/blackjack/img/logo_books.png" style="vertical-align:middle; margin: 0 8px 0 0;"/></span>
		<a href="<?php echo $baseUrl ?>/index.php?lang=<?echo $lang ?>"><?echo $label_to_toppage ?></a>
	</h3>

	<?php
		for( $n=0; $n<count( $episodes[$lang] ); $n++ ) {
			$temp = $n + 1;
			echo '<h3>'.get_volume_presentation( $lang, $n ).'</h3>';
			foreach( $episodes[$lang][$n] as $key => $val ) {
				echo get_episode_link( $baseUrl, $lang, $n, $key, $val ).'<br>';
			}
		}
	?>
		<br /><br />

		<?php include('./include/copyrights.php'); ?>
	</div><!-- end of #sidebar -->

</div><!-- end of #wrapper -->
<div class="clear"></div>

<div class="footer">Presented by <a href="http://dev.ontheroad.jp/">MacBook Air と WordPress でこうなった</a></div>
</body></html>

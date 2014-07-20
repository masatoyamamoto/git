#!usr/bin/perl
use strict;
use warnings;

#module WWW::Mechanizeを読み込む
use WWW::Mechanize;
use HTML::TreeBuilder;
use Encode;

#constructor
my $mech =  WWW::Mechanize->new(autocheck => 1);

#actual code
$mech -> get("http://www.actuaries.jp/lib/collection/");

#linkの取得
my @link_list = $mech->links;
my @content = $mech->content;

my @urlList;
my @nameList;
my @yearList;
my $name = "";

foreach (@link_list){
	my $url = $_->url_abs; #リンク
	my $temp2 = $_->url; #短縮リンク
	$temp2=~/\/.*\//;
	my $temp3 = substr($&,1,3);
	$name = encode("utf-8",$_->text);
	if ($url=~/.pdf\z/){
=pod
		print $name."\n";
		print $temp3."\n";
		print $url."\n\n";
=cut
		push @urlList, $url;
		push @yearList, $temp3;
		push @nameList, $name;
	}
} 
#ここまででリンク,年度の取得は完了。
for(my $i = 0; $i <= $#urlList ; $i++ ){
	print $i;
	my $tempMech = WWW::Mechanize -> new(autocheck => 1);
	if (-e "actuary/".$yearList[$i]){
	}else{
		mkdir "actuary/".$yearList[$i], 0755 or warn "Cannot make directory:". $yearList[$i];
	}
	$tempMech -> get($urlList[$i],":content_file" => "actuary/$yearList[$i]/$nameList[$i].pdf");
}

print "------------------------------------end of the program ---------------------------------\n\n\n\n\n";

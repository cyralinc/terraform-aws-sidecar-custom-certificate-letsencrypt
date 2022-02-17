my $cft = $ARGV[0];
open my $fh, "<", $cft;
while (<$fh>) {
    if ( /("sidecar-certificate-manager\/.*.zip")/ ) {
        print "$1"
    }
}

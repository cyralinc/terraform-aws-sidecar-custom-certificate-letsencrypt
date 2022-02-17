my $entire_file_str = <STDIN>;
my $injection_key = $ARGV[0];
if (not $entire_file_str =~ s/(s3_deployment_code_key *=.*?.*:.*)".*"/${1}$injection_key/) {
    die "Did not found pattern in:\n$input"
}
print "$entire_file_str"

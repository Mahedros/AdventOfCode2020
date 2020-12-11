my $filename = 'input.txt';

open($FH, '<', $filename) or die $!;
chomp(my @lines = <$FH>);
close $FH;

my @entries;

for my $line (@lines) {
	my @tokens = split(' ', $line);
	my @range = split('-', $tokens[0]);
	my $lower = $range[0];
	my $upper = $range[1];
	my $letter = substr($tokens[1], 0, 1);
	my $password = $tokens[2];
	push(@entries, [($lower, $upper, $letter, $password)]);
}

sub part_1 {
	my @values = @_;
	my $valid_count = 0;
	for my $entry (@values) {
		
	}
}

sub part_2 {
	my @values = @_;
	my $valid_count = 0;
	for my $entry (@values) {
		
	}
}

part_1(@entries);
part_2(@entries);
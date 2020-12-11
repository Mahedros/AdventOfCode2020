my $filename = 'input.txt';
open($handle, '<', $filename) or die $!;
chomp(my @lines = <$handle>);
close $handle;

sub part_1 {
	my @lines = @_;
	for my $i (0..@lines - 1) {
		my $found = 0;
		if ($i >= 25) {
			for my $j (($i - 25)..($i - 2)) {
				for my $k (($j + 1)..($i - 1)) {
					if ($lines[$i] == $lines[$j] + $lines[$k]) {
						$found = 1;
						last;
					}
				}
				if ($found) {
					last;
				}
			}
			if (!$found) {
				return $lines[$i];
			}
		}
	}
}

sub part_2 {
	my $invalid_number = shift;
	my @lines = @_;
	for my $i (0..@lines - 1) {
		my $j = $i;
		my $sum = 0;
		my $smallest = "inf";
		my $largest = "-inf";
		while ($sum < $invalid_number and $j < @lines) {
			$sum += $lines[$j];
			if ($lines[$j] < $smallest) {
				$smallest = $lines[$j];
			}
			if ($lines[$j] > $largest) {
				$largest = $lines[$j];
			}
			$j++;
		}
		if ($sum == $invalid_number) {
			return $smallest + $largest;
		}
	}
}

my $invalid_number = part_1(@lines);
print(part_2($invalid_number, @lines));
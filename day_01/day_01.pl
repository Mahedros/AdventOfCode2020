my $filename = 'input.txt';

open($FH, '<', $filename) or die $!;
chomp(my @lines = <$FH>);
close $FH;

sub part_1 {
	my @values = @_;
	my $length = @values;
	for my $i (0..$length - 2) {
		for my $j ($i..$length - 1) {
			if ($values[$i] + $values[$j] == 2020) {
				print($values[$i] * $values[$j]);
				return;
			}
		}
	}
}

sub part_2 {
	my @values = @_;
	my $length = @values;
	for my $i (0..$length - 2) {
		for my $j ($i..$length - 1) {
			if ($values[$i] + $values[$j] < 2020) {
				for my $k (0..$length - 1) {
					if ($k == $i or $k == $j) {
						next;
					}
					if ($values[$i] + $values[$j] + $values[$k] == 2020) {
						print($values[$i] * $values[$j] * $values[$k]);
						return;
					}
				}
			}
		}
	}
}

part_1(@lines);
print("\n");
part_2(@lines);
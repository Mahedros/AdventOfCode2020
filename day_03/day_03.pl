my $filename = 'input.txt';

open($handle, '<', $filename) or die $!;
chomp(my @lines = <$handle>);
close $handle;

my @grid;

for my $line (@lines) {
	my @spaces = split('', $line);
	my $spaces_ref = \@spaces;
	push(@grid, $spaces_ref);
}

sub part_1 {
	my $row_shift = shift;
	my $col_shift = shift;
	my @grid = @_;
	my $row = 0;
	my $column = 0;
	my $tree_count = 0;
	my $num_rows = @grid;
	my $num_cols = scalar(@{$grid[0]});
	while ($row < $num_rows) {
		if ($row != 0) {
			if ($grid[$row][$column] eq '#') {
				$tree_count++;
			}
		}
		$row += $row_shift;
		$column = ($column + $col_shift) % $num_cols;
	}
	return $tree_count;
}

sub part_2 {
	my $product = 1;
	$product *= part_1(1, 1, @_);
	$product *= part_1(1, 3, @_);
	$product *= part_1(1, 5, @_);
	$product *= part_1(1, 7, @_);
	$product *= part_1(2, 1, @_);
	return $product;
}

print(part_1(1, 3, @grid), "\n");
print(part_2(@grid));
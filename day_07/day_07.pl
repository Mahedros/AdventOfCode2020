my $filename = 'input.txt';
open($handle, '<', $filename) or die $!;
chomp(my @lines = <$handle>);
close $handle;

my %rules;

for my $line (@lines) {
	my @spaces = split(' ', $line);
	my $outer = $spaces[0].' '.$spaces[1];
	my @contents;
	if ($line =~ /(\d+.*)$/) {
		@contents = split(',', $1);
		s{^\s+|\s+$|\.$}{}g foreach @contents;
		s{bags$|bag$}{}g foreach @contents;
		s{^\s+|\s+$|\.$}{}g foreach @contents;
	}
	else {
		@contents = ();
	}
	$rules{$outer} = \@contents;
}

sub contains_gold {
	my $key = shift;
	my %rules = @_;
	my $contents = $rules{$key};
	my $result;
	for my $sub_bag (@$contents) {
		if ($sub_bag =~ /\d+\sshiny\sgold/) {
			return 1;
		}
		if ($sub_bag =~ /\d+\s(.*)$/) {
			$result = contains_gold($1, %rules);
			if ($result) {
				return 1;
			}
		}
	}
	return 0;
}

sub part_1 {
	my %rules = @_;
	my $gold_count = 0;
	for my $key (keys %rules) {
		if (contains_gold($key, %rules)) {
			$gold_count++;
		}
	}
	print($gold_count);
}

sub sub_count {
	my $key = shift;
	my %rules = @_;
	my @contents = @{$rules{$key}};
	my $bag_count = 1;
	if (@contents == 0) {
		return 1;
	}
	for my $sub_bag (@contents) {
		if ($sub_bag =~ /(\d+)\s(.*)$/) {
			my $count = $1;
			my $sub_key = $2;
			my $sub_total = sub_count($sub_key, %rules);
			print("Each ".$sub_key." contributes ".$sub_total." bags", "\n");
			#$bag_count += $count * sub_count($sub_key, %rules);
			$bag_count += $count * $sub_total;
		}
	}
	return $bag_count;
}

sub part_2 {
	my %rules = @_;
	my $bag_count = sub_count('shiny gold', %rules);
	print($bag_count - 1);
}

#part_1(%rules);
part_2(%rules);
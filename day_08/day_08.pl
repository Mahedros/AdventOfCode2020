my $filename = 'input.txt';
open($handle, '<', $filename) or die $!;
chomp(my @lines = <$handle>);
close $handle;

sub part_1 {
    my @lines = @_;
    my @usage_counts = (0) x @lines;
    my $curr_line = 0;
    my $accumulator = 0;
    while($usage_counts[$curr_line] < 1) {
    	my $line = $lines[$curr_line];
    	$usage_counts[$curr_line] += 1;
    	if($line =~ /(nop|acc|jmp)\s(-|\+)(\d+)/) {
	    	my $command = $1;
	    	my $sign = $2;
	    	my $value = $3;
	    	if ($command eq 'acc') {
	    		if ($sign eq '-') {
	    			$accumulator -= $value;
	    		} else {
	    			$accumulator += $value;
	    		}
	    		$curr_line++;
	    	} elsif ($command eq 'jmp') {
	    		if ($sign eq '-') {
	    			$curr_line -= $value;
	    		} else {
	    			$curr_line += $value;
	    		}
	    	} else {
	    		$curr_line++;
	    	}
    	}
    }
    print($accumulator);
    return @usage_counts;
}

sub check_termination {
	my $flip_index = shift;
	my @lines = @_;
	my $accumulator = 0;
	my $curr_line = 0;
	my @usage_counts = (0) x @lines;
	my $did_terminate = 0;
	while ($usage_counts[$curr_line] < 1 and $curr_line < @lines) {
		my $line = $lines[$curr_line];
    	$usage_counts[$curr_line] += 1;
    	if($line =~ /(nop|acc|jmp)\s(-|\+)(\d+)/) {
	    	my $command = $1;
	    	my $sign = $2;
	    	my $value = $3;
	    	if ($curr_line == $flip_index) {
	    		if ($command eq 'nop') {
	    			$command = 'jmp';
	    		} elsif ($command eq 'jmp') {
	    			$command = 'nop';
	    		}
	    	}
	    	if ($command eq 'acc') {
	    		if ($sign eq '-') {
	    			$accumulator -= $value;
	    		} else {
	    			$accumulator += $value;
	    		}
	    		$curr_line++;
	    	} elsif ($command eq 'jmp') {
	    		if ($sign eq '-') {
	    			$curr_line -= $value;
	    		} else {
	    			$curr_line += $value;
	    		}
	    	} else {
	    		$curr_line++;
	    	}
    	}
	}
	if ($curr_line == @lines) {
		$did_terminate = 1;
	}
	return ($did_terminate, $accumulator);
}

sub part_2 {
	my @lines = @{$_[0]};
	my @used_lines = @{$_[1]};
	my $accumulator = 0;
	my $did_terminate = 0;
	for my $i (0..@lines - 1) {
		if ($used_lines[$i] and $lines[$i] =~ /nop|jmp/) {
			($did_terminate, $accumulator) = check_termination($i, @lines);
			if ($did_terminate) {
				return $accumulator;
			}
		}
	}
}

my @used_lines = part_1(@lines);
print("\n");
print(part_2(\@lines, \@used_lines));


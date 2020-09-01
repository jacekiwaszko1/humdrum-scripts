#!/usr/bin/env perl
use strict;
my @input = <>;
my @first;
my @postpone;
for (my $i = 0; $i < @input; $i++) {
  my @line = split("\t", $input[$i]);
  my $tremON;
  if ($input[$i] =~ /\@[0-9]+@/) {
    $tremON = 1;
  }

  my $tremONline;
  my $tremOFFline;
  for (my $j = 0; $j < @line; $j++) {
    if ($tremON) {
      if ($line[$j] =~ /\@[0-9]+\@/) {
        my $firstQ;
        if (!$first[$j]) {
          $first[$j]++;
          $firstQ = 1;
        }
        if ($firstQ) {
          $tremONline .= "*";
        } else {
          $tremONline .= "*tremolo";
        }
        my $postponeQ = postponeQ($i,$j,@input);
        if ($postponeQ) {
          my $postponedLine;
          my $postLine = getPostLine($i,$j,@input);
          for (my $k = 0; $k < @line; $k++) {
            my $nextToken = getNextToken($postLine,$k,@input);
            if ($k == $j) {
              $postponedLine .= "*Xtremolo";
            } elsif (!$nextToken) {
              $postponedLine .= "";
            } else {
              $postponedLine .= "*";
            }
            if ($k+1 == @line) {
              $postponedLine .= "\n";
            } else {
              $postponedLine .= "\t";
            }
          }
          $input[$postLine] = "$postponedLine" . "$input[$postLine]";
          $postpone[$j] = 1;
        }
        if ($postpone[$j]) {
          $tremOFFline .= "*";
          $postpone[$j] = 0;
        } else {

          my $last = checkLast($i,$j,@input);
          if (!$last) {
            $tremOFFline .= "*";
          } else {
            $tremOFFline .= "*Xtremolo";
          }

        }
      } elsif ($line[$j] == "") {
        $tremONline .= "";
        $tremOFFline .= "";
      } else {
        $tremONline .= "*";
        $tremOFFline .= "*";
      }
      if ($j+1 == @line) {
        $tremONline .= "\n";
        $tremOFFline .= "\n";
      } else {
        $tremONline .= "\t";
        $tremOFFline .= "\t";
      }
    }
  }

  print $tremONline unless $tremONline =~ /^[\*\t]*\n?$/;
  print "$input[$i]";
  print $tremOFFline unless $tremOFFline =~ /^[\*\t]*\n?$/;
}


###SUBS:
sub postponeQ {
  my ($x,$y,@in) = @_;
  my $nextX = $x+1;
  my $return;
  for (my $i = $nextX; $i < @input; $i++) {
    chomp $in[$i];
    my @ln = split("\t", $in[$i]);
    if ($ln[$y] =~ /^[\*\!].*$/) {
      next;
    } elsif ($ln[$y] =~ /\./) {
      $return++;
      last;
    } else {
      last;
    }
  }
  return $return;
}

sub getPostLine {
  my ($x,$y,@in) = @_;
  my $nextX = $x+1;
  my $return;
  for (my $i = $nextX; $i < @in; $i++) {
    my @ln = split("\t", $in[$i]);
    if ($ln[$y] =~ /[0-9]+\.[a-gA-G]/ ||
        $ln[$y] =~ /^=/) {
      $return = $i;
      last;
    } else {
      next;
    }

  }
  return $return;
}

sub checkLast {
  my ($x,$y,@in) = @_;
  my $nextX = $x+1;
  my $return;
  for (my $i = $nextX; $i < @in; $i++) {
    my @ln = split("\t", $in[$i]);
    if ($ln[$y] =~ /\@[0-9]+\@/) {
      $return++;
      last;
    } else {
      next;
    }

  }
  return $return;
}

sub getNextToken {
  my ($x,$y,@in) = @_;
  my $nextX = $x+1;
  my $return;
  my @ln = split("\t", $in[$nextX]);
  $return = $ln[$y];
  return $return;
}

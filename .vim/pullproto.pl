#!/usr/bin/perl

my $file = shift;

sub usage
{
    print <<EOH;
usage: pullproto.pl <filename>

  filename  The (header) file from which to pull the prototype

  STDIN should have a list of directives that define what prototypes 
  to pull from <filename>.  The lines should look like this:

  <line number>|<function name>|[class]

  where class is optional and need not be supplied if the function
  is not a member function of a class.
EOH
}

if (!defined($file))
{
    usage();
    exit(1);
}
if (! -r $file)
{
    print STDERR "$file is not readable.";
    exit(1);
}
open INFILE, "<$file" or die "unable to open $file";
my @c = <INFILE>;
close INFILE;

while (<STDIN>)
{
    chomp;
    my $linenum = "";
    my $function = "";
    my $class = "";
    ($linenum, $function, $class) = split /\|/, $_;
    my @temp = @c;
    if ($temp[$linenum - 2] =~ m/$function/)
    {
        @temp = @temp[$linenum - 1..$#temp]
    }
    else
    {
        @temp = @temp[$linenum - 2..$#temp]
    }

    my $content = join "", @temp;
    my $fname = "";
    my $pre = "";
    my $post = "";
    if ($function =~ m/^operator/)
    {
        $function =~ s/\s//g;
    }
    my ($justclass) = $class =~ m/^.*::(.*)$/;
    $justclass = $class if !defined($justclass) || $justclass eq "";
    if ($function eq $justclass || $function eq "~$justclass")
    {
        ($fname, $post) = $content =~ m/($function)\s*(\([^\)]*\)[^;]*);/m;
    }
    else
    {
        my @a = $content =~ m/(const)?\s*(unsigned)?\s*(\S+)\s*($function)\s*(\([^\)]*\)[^;]*);/m;
        my $str = join(" ", @a);
        ($pre, $fname, $post) = $str =~ m/(.*\s)($function)\s(.*)/s;
        $pre =~ s/\s+/ /g;
        $pre =~ s/^\s+//g;
    }
    print "==\n";
    if ($class ne "")
    {
        print "$pre$class" . "::" . "$fname$post";
    }
    else
    {
        print "$pre$fname$post";
    }
    print "\n";
}

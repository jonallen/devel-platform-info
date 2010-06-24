package Devel::Platform::Info;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.01';

#----------------------------------------------------------------------------

my %map = (
    'linux' => 'Linux',
);

#----------------------------------------------------------------------------

sub new {
    my ($class) = @_;
    my $self    = {};
    bless  $self, $class;
    return $self;
}

sub get_info {
    my $self  = shift;
    my $data;

    my $driver = 'Devel::Platform::Info::' . $map{ lc $^O };
    my $require = $driver;
    $require =~ s!::!/!g;

    eval {
        require "$require.pm";
        my $info = $driver->new();
        $data = $info->get_info();
    };

    return  if($@);
    return $data;
}

1;

__END__

=head1 NAME

Devel::Platform::Info - Retrieve common platform metadata

=head1 SYNOPSIS

  use Devel::Platform::Info;
  my $info = Devel::Platform::Info->new();
  my $data = $info->get_info();

=head1 DESCRIPTION

This module is a wrapper to the drivers which can determine platform metadata
regarding the currently running operating system.

=head1 INTERFACE

=head2 The Constructor

=over

=item * new

Simply constructs the object.

=back

=head2 Methods

=over 4

=item * get_info

Returns a hash reference to the platform metadata.

=back

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties, that is not explained within the POD
documentation, please send bug reports and patches to the RT Queue (see below).

RT Queue -
http://rt.cpan.org/Public/Dist/Display.html?Name=Devel-Platform-Info

=head1 AUTHORS

  Barbie (BARBIE) <barbie@cpan.org>
  Brian McCauley (NOBULL) <nobull67@gmail.com>
  Colin Newell http://colinnewell.wordpress.com/
  Jon 'JJ' Allen (JONALLEN) <jj@jonallen.info>

=head1 COPYRIGHT & LICENSE

  Copyright (C) 2010 Birmingham Perl Mongers

  This module is free software; you can redistribute it and/or
  modify it under the Artistic License 2.0.

=cut
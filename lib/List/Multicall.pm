package List::Multicall;
# Abstract - Quickly call functions for each member of a list
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(multicall);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('List::Multicall', $VERSION);

1;
__END__

=head1 NAME

List::Multicall - Quickly call functions for each member of a list

=head1 SYNOPSIS

  use List::Multicall qw(multicall);

  my @list = qw(1..100_000_000);

  # Use $_ instead of @_ !
  sub negative { $_ *= -1 }

  multicall(\&negative, @list);

  # Basically, the above is:
  negative() for @list;
  # But slightly faster (Why??)

=head1 DESCRIPTION

This module provides a single method L</"multicall"> which utilizes Perl's
MULTICALL functionality (see L<perlcall/LIGHTWEIGHT CALLBACKS>) to allow you to 
quickly call subroutines for each element in a list.

=head1 METHODS

=head2 multicall

  multicall($coderef, @list);

For each element in C<@list>, execute C<$coderef>, setting C<$_> to
the element's value.

=head1 AUTHOR

Matthew Horsfall (alh) - <wolfsage@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Matthew Horsfall

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

package t::Course;

use Moose;

has 'name' => (isa => 'Str', is => 'ro');

has 'holes' => (isa => 'ArrayRef', is => 'ro');

1;
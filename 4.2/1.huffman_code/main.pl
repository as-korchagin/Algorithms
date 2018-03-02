#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use 5.010;

$|++;

package Node;{

    use overload
        '<' => sub {
            return $_[0]->getFreq() < $_[1]->getFreq();
        };

    sub new {
        my ($class, $left_leaf, $right_leaf) = @_;
        my $self = {
            "name"       => "Node",
            "left_leaf"  => $left_leaf,
            "right_leaf" => $right_leaf
        };
        bless $self, $class;
        return $self;
    }

    sub getFreq {
        my ($self) = @_;
        return $self->{'freq'};
    }

    sub walk {
        my ($self, $code, $prefix) = @_;
        $self->{'left_leaf'}->walk($code, $prefix . '0');
        $self->{'right_leaf'}->walk($code, $prefix . '1');
    }

}

package Leaf;{

    use Data::Dumper;

    use overload
        '<' => sub {
            return $_[0]->getFreq() < $_[1]->getFreq();
        };

    sub new {
        my ($class, $letter, $freq) = @_;
        my $self = {
            "name"   => 'Leaf',
            "freq"   => $freq,
            "letter" => $letter
        };
        bless $self, $class;
        return $self;
    }

    sub getLetter {
        my ($self) = @_;
        return $self->{'letter'};
    }

    sub getFreq {
        my ($self) = @_;
        return $self->{'freq'};
    }

    sub walk {
        my ($self, $code, $prefix) = @_;
        $code->{$self->getLetter()} = $prefix;
    }

}

sub encode {
    my @string_to_encode = @_;
    my %letter_usage;
    my @leafs;
    foreach (@string_to_encode) {
        $letter_usage{$_} += 1;
    }
    foreach (keys %letter_usage){
        push @leafs, Leaf->new($_, $letter_usage{$_})
    }
    print Dumper(@leafs);
}

my $string_to_encode;
chomp($string_to_encode = <STDIN>);
encode(split //, $string_to_encode);
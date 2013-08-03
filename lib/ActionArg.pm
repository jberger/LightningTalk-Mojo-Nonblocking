package ActionArg;
use Mojo::Base 'Mojolicious::Plugin';

sub register {
  my ($self, $app, $conf) = @_;
  my @keys = @{ $conf->{keys} };

  $app->hook( around_action => sub {
    my ($next, $c, $action, $last) = @_;
    return $next->() unless $last; # don't act on bridges

    $c->$action( map { $c->stash($_) } @keys );
  });
}

1;


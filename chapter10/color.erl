% color.erl

-module(color).
-export([from16to24/1, from24to16/1]).

from16to24(Bitmap) ->
  << <<R:5, 0:3, G:6, 0:2, B:5, 0:3>> || <<R:5, G:6, B:5>> <= Bitmap >>.

from24to16(Bitmap) ->
  << <<R:5, G:6, B:5>> || <<R:5, _:3, G:6, _:2, B:5, _:3>> <= Bitmap >>.

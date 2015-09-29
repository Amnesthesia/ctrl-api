CTRL API
================

This is the API for a so-far unnamed iOS (and future, Android) app that allows "crowdsourcing" of control information for
public transport in the Oslo area. It may however work with other areas in Norway as well.

There's a rake task `rake nodes:sync` that synchronizes nodes (stations) with Ruter's public API and converts the UTM32
coordinates to "normal" coordinates, which should be run when setting it up.

Other than that, it's fairly simple - when a user sends coordinates, device UUID, and whether or not there's a control (true or false),
the closest node is found and a relationship is updated. The app can then display how many people marked the closest node as
control, or not control - and if the delta between these is more than 30, it's considered a verified status.

There's probably better ways of doing this, and I need to think of a way to keep history (like grouping control information on a 5 or 15 minute basis),
but that's all so far.
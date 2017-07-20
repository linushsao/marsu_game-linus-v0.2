jetpack = {}

--This grants and revokes the fast priv along with fly when it is set to true.
--If you grant the fast priv on your server, do *not* enable it.
--As when the effect wears off, the fast priv of the player will go as well.
jetpack.fast = false

--Times for each of the jetpack types.
--I advise increasing them if fast is not a default priv and jetpack.fast = false.
--They are at the curent times because any longer allows large distances to be covered with fast.
--Even with this, the gold jetpack allow players with fast to cover almost 300 nodes.
jetpack.time = 7
jetpack.time_bronze = 15
jetpack.time_gold = 30

--If you want jetpack to be avalible only through /giveme or at admin shops, set this to false
jetpack.crafts = true

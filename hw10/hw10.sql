CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM parents, dogs WHERE parent = name ORDER BY height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes WHERE height > min AND height <= max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child as sib1, b.child as sib2, c.size as dogSize 
  from parents as a, parents as b, size_of_dogs as c, size_of_dogs as d
  where a.parent = b.parent and a.child = c.name and b.child = d.name and a.child < b.child and c.size = d.size;


-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || sib1 || " and " || sib2 || ", have the same size: " || dogSize
  FROM siblings;
  


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, max(height) - min(height)
  from dogs
  group by fur 
  having max(height) < 1.3 * avg(height) and min(height) > .7 * avg(height);

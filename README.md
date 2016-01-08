normalize
==========

Contains the basics for corporate/imprint/agency string normalization.

Mostly ripped from the duplicate detection script "normalize_agency" with a few alterations. 

normalize_lccn
==============
Spec taken from http://www.loc.gov/marc/lccn-namespace.html 

Will give ArgumentError "Invalid LCCN" if it can't normalize to a valid LCCN. 

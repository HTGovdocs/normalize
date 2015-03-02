=begin

Mostly just a subset of the normalize_corporate stuff 

=end

def normalize_title( title )
  t = title.upcase; 
  t.gsub!(/[,\.:;"]|\'S?/, '');   # punctuations
  t.gsub!(/[\(\)\{\}\[\]]/, ''); # Brackets

  # Stop words  
  t.gsub!(/\b(THE) /, '');
  t.gsub!(/\b(AND) /, '');

  # Abbreviations et cetera.
  t.gsub!(/\bDEPT\b/, 'DEPARTMENT');
  t.gsub!(/\bDEPTOF/, 'DEPARTMENT OF'); # Strangely common typo(?)

  # stupid xml entities
  t.gsub!(/&(AMP)?(#X26)?/, '');

  t.gsub!(/UNITED TATES/, 'UNITED STATES');
  t.gsub!(/UNITED STATES( OF AMERICA)?/, 'UNITED STATES');
  t.gsub!(/\bUS\b/, 'UNITED STATES'); #dangerous?
  t.gsub!(/\bUSA\b/, 'UNITED STATES'); #dangerous?
  t.gsub!(/U\sS\s|U S$/, 'UNITED STATES ');
  t.gsub!(/GOV'T/, 'GOVERNMENT');
  t.gsub!(/GOVT/, 'GOVERNMENT');
  t.gsub!(/ SPN$/, '');
  if t !~ /CONFEDERATE STATES OF AMERICA/  #seriously...
    t.gsub!(/HOUSE( OF)? REPRESENTATIVES/, 'HOUSE ');
  end

  # US GOVT PRINT OFF, which is so common yet has so many variations.
  t.sub!(/(US\s?)?GOVT\s?PRINT(ING)?\s?OFF(ICE)?/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  t.sub!(/U\s?S\s?G\s?P\s?O/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  t.sub!(/^GPO$/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  t.sub!(/UNITED STATES GOVERNMENT PRINT OFF/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  
  
  #mostly congressional stuff
  t.sub!(/(\d?)2D/, '\12ND'); 
  t.sub!(/(\d?)3D/, '\13RD'); 
  t.sub!(/\b(CONG)\b/, 'CONGRESS');
  t.sub!(/\b(SESS)\b/, 'SESSION');
  t.sub!(/\b(\d+[A-Z]{2}) CONGRESS\b/, 'CONGRESS \1'); #congress then session info
  t.sub!(/COM+IT+E+(S)?(\b)/, 'COMMITTEE\1\2'); #spelling ftw

  #oops
  t.sub!(/UNITED STATES UNITED STATES/, 'UNITED STATES');
  t.sub!(/PERMAMENT/, 'PERMANENT'); 
  
  t.gsub!(/ +/, ' '); # whitespace
  t.sub!(/^ +/,  '');
  t.sub!(/ +$/,  '');

  return t

end




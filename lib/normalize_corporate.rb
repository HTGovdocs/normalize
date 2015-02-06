
def normalize_corporate( corp )
  ag = corp.upcase; 
  ag.gsub!(/[,\.:;]|\'S?/, '');   # punctuations
  ag.gsub!(/[\(\)\{\}\[\]]/, ''); # Brackets
  ag.gsub!(/FOR SALE BY/, '');  # I AM NOT INTERESTED IN WHAT YOU ARE SELLING. #some are GPO
  ag.gsub!(/\b(THE) /, '');       # Stop words

  # Abbreviations et cetera.
  ag.gsub!(/DEPARTMENT/, 'DEPT');
  ag.gsub!(/DEPTOF/, 'DEPT OF'); # Strangely common typo(?)

  ag.gsub!(/&(AMP)?(#X26)?/, ' AND ');
  

  ag.gsub!(/UNITED STATES( OF AMERICA)?/, 'UNITED STATES');
  ag.gsub!(/\bUS\b/, 'UNITED STATES'); #dangerous?
  ag.gsub!(/\bUSA\b/, 'UNITED STATES'); #dangerous?
  ag.gsub!(/U\sS\s|U S$/, 'UNITED STATES ');
  ag.gsub!(/GOV'T/, 'GOVERNMENT');
  ag.gsub!(/GOVT/, 'GOVERNMENT');
  ag.gsub!(/ SPN$/, '');
  if ag !~ /CONFEDERATE STATES OF AMERICA/  #seriously...
    ag.gsub!(/HOUSE( OF)? REPRESENTATIVES/, 'HOUSE ');
  end

  # US GOVT PRINT OFF, which is so common yet has so many variations.
  ag.sub!(/(US\s?)?GOVT\s?PRINT(ING)?\s?OFF(ICE)?/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  ag.sub!(/U\s?S\s?G\s?P\s?O/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  ag.sub!(/^GPO$/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  ag.sub!(/UNITED STATES GOVERNMENT PRINT OFF/, 'UNITED STATES GOVERNMENT PRINTING OFFICE');
  
  
  #mostly congressional stuff
  ag.sub!(/(\d?)2D/, '\12ND'); 
  ag.sub!(/(\d?)3D/, '\13RD'); 
  ag.sub!(/\b(CONG)\b/, 'CONGRESS');
  ag.sub!(/\b(SESS)\b/, 'SESSION');
  ag.sub!(/\b(\d+[A-Z]{2}) CONGRESS\b/, 'CONGRESS \1'); #congress then session info
  ag.sub!(/COM+IT+E+(S)?(\b)/, 'COMMITTEE\1\2'); #spelling ftw

  #authorities drop the inc, so we probably should too
  ag.sub!(/\b(INC)$/, ''); 

  if ag !~ /COMMITTEE/ and ag !~ /OFFICE/ and ag !~ /CAUCUS/  \
     and ag !~ /CONFEDERATE/ and ag !~ /STUDY/ #overreach?
    ag.sub!(/HOUSE /, 'HOUSE COMMITTEE ON ');
    ag.sub!(/SENATE /, 'SENATE COMMITTEE ON ');
  else
    ag.sub!(/UNITED STATES (CONGRESS )?(HOUSE |SENATE )(.*) COMMITTEE$/, 'UNITED STATES \1\2COMMITTEE ON \3');
  end

  #oops
  ag.sub!(/UNITED STATES UNITED STATES/, 'UNITED STATES');

  #one off fixes
  ag.sub!(/^UNITED STATES EDUCATION OFFICE$/, 'UNITED STATES OFFICE OF EDUCATION');
  ag.sub!(/^UNITED STATES ENGINEERS CORPS$/, 'UNITED STATES ARMY CORPS OF ENGINEERS');
  ag.sub!(/UNITED STATES ENGINEERS CORPS ARMY$/, 'UNITED STATES ARMY CORPS OF ENGINEERS');
  ag.sub!(/ATOMIC ENERGY JOINT COMMITTEE/, 'JOINT COMMITTEE ON ATOMIC ENERGY');
  ag.sub!(/ECONOMIC JOINT COMMITTEE/, 'JOINT ECONOMIC COMMITTEE');
  ag.sub!(/^UNITED STATES LIBRARY OF CONGRESS$/, 'LIBRARY OF CONGRESS'); #librarians think they're special

  ag.sub!(/UNITED STATES STATE DEPT\b/, 'UNITED STATES DEPT OF STATE');
  ag.sub!(/UNITED STATES JUSTICE DEPT\b/, 'UNITED STATES DEPT OF JUSTICE');
  ag.sub!(/UNITED STATES INTERIOR DEPT\b/, 'UNITED STATES DEPT OF INTERIOR');
  ag.sub!(/UNITED STATES COMMERCE DEPT\b/, 'UNITED STATES DEPT OF COMMERCE');
  ag.sub!(/UNITED STATES CIVIL(IAN)? DEFENSE OFFICE\b/, 'UNITED STATES OFFICE OF CIVIL\1 DEFENSE'); 
  
  ag.gsub!(/ +/, ' '); # whitespace
  ag.sub!(/^ +/,  '');
  ag.sub!(/ +$/,  '');

  return ag

end




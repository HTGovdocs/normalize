module Normalize

  def Normalize.enum_chron e
    e.upcase!;
    e.gsub!(/ +/, " ");

    # Deal with copies
    e.gsub!(/\b(C|COPY?)[ .]*\d+/, "");
    e.gsub!(/(\d+(ST|ND|RD|TH)|ANOTHER) COPY/, "");

    e.gsub!(/VOL(UME)?/, "V");
    e.gsub!(/SUPP?(L(EMENT)?)?S?/, "SUP");
    e.gsub!(/&/, " AND ");
    e.gsub!(/\.(\S)/, ". \\1");
    e.gsub!(/\*/, "");
    e.strip!;

    return e;
  end
end


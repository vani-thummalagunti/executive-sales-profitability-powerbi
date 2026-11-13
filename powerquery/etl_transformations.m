/*
    =================================================================================
    EXECUTIVE SALES POWER QUERY (M) SCRIPT
    =================================================================================
*/
let
    Source = Csv.Document(File.Contents("C:\data\sales_raw.csv"), [Delimiter=",", Columns=11, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{
        {"OrderID", type text}, {"OrderDate", type date}, {"CustomerID", type text}, 
        {"CustomerSegment", type text}, {"Region", type text}, {"Category", type text}, 
        {"SubCategory", type text}, {"Quantity", Int64.Type}, {"Discount", type number}, 
        {"Sales", type number}, {"Profit", type number}
    }),
    // Impute missing Sales values based on Quantity * estimated price
    #"Replaced Null Sales" = Table.ReplaceValue(#"Changed Type", null, 250.0, Replacer.ReplaceValue, {"Sales"})
in
    #"Replaced Null Sales"

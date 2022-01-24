//
//  CalcValues.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import Foundation

func calcYearlyVals(rate: String, initial: String, time: String, contributionAmt: String, compounding: compoundType) -> [Double] {
    let cRate = (Double(rate) ?? 0) / 100
    let cInitial = Double(initial) ?? 0
    let cTime = Int(time) ?? 0
    let cContributionAmt = Double(contributionAmt) ?? 0
    var numberCompound = 1.0;
    switch compounding {
    case .day : numberCompound = 365.0
    case .week : numberCompound = 52.0
    case .month : numberCompound = 12.0
    case .quarter : numberCompound = 4.0
    default : numberCompound = 1.0
    }
    
    var currVal = cInitial
    var calcVals = [cInitial]
    
    for _ in 0 ..< cTime {
        currVal += (cContributionAmt * 12)
        currVal = currVal * pow((1 + (cRate / numberCompound)), numberCompound)
        let roundedVal = round(currVal * 100) / 100.0
        calcVals.append(roundedVal)
    }
    
    return calcVals
}
//
//  Gate.swift
//  Computer Test
//
//  Created by Piotrek on 19/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation

public class Gate {
    let width: Int
    let matrix: Matrix
    
    //Init new clear Gate
    required init(width: Int, matrix: Matrix) {
        self.width = width
        self.matrix = matrix
    }
    
    //Permutate gates matrix
    func permute(permutation: [Int]) -> Gate {
        let m = self.matrix.permuteRows(permutation: permutation)
        
        return Gate(width: self.width, matrix: m)
    }
}

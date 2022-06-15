/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.math.BigDecimal;
import rs.etf.sab.operations.PackageOperations.Pair;

/**
 *
 * @author asusg750
 */
public class ss170201_PairOffer  implements Pair{
    private int id;
    private BigDecimal percentage;

    public ss170201_PairOffer(int id, BigDecimal percentage) {
        this.id = id;
        this.percentage = percentage;
    }

    @Override
    public Object getFirstParam() {
        return id;
    }

    @Override
    public Object getSecondParam() {
        return percentage;
    }
}

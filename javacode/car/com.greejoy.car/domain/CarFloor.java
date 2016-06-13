package com.greejoy.car.domain;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-26
 * Time: 下午10:18
 * To change this template use File | Settings | File Templates.
 */
public class CarFloor {
    private int floor_num;
    private int leftseats;
    private int occupySeats;
    private int parking_lot;
    private int percent;

    public int getPercent() {
        return percent;
    }

    public void setPercent(int percent) {
        this.percent = percent;
    }

    public int getParking_lot() {
        return parking_lot;
    }

    public void setParking_lot(int parking_lot) {
        this.parking_lot = parking_lot;
    }

    public int getOccupySeats() {
        return occupySeats;
    }

    public void setOccupySeats(int occupySeats) {
        this.occupySeats = occupySeats;
    }

    public int getFloor_num() {
        return floor_num;
    }

    public void setFloor_num(int floor_num) {
        this.floor_num = floor_num;
    }

    public int getLeftseats() {
        return leftseats;
    }

    public void setLeftseats(int leftseats) {
        this.leftseats = leftseats;
    }
}

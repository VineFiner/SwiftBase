//
//  DimensionC.c
//  Subscripts
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 Vine. All rights reserved.
//

#include "DimensionC.h"

/*
 *  arr[3][4]  arr[0]看做是一个一维数组的数组名
 *  [0][0] [0][1] [0][2] [0][3]
 *  [1][0] [1][1] [1][2] [1][3]
 *  [2][0] [2][1] [2][2] [2][3]
 * */

void test() {
    int arr[3][4] = {
        {1,2,3,4},
        {5,6,7,8},
        {9,10,11,12}
    };
    int arr1[3][4] = {250,250,250,4,2,2,3,4,3,2,3,4};
    
    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 4;j++)
        {
            printf("%d ", arr[i][j]);
        }
        putchar('\n');
    }
    putchar('\n');
    putchar('\n');

    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 4;j++)
        {
            printf("%d ", arr1[i][j]);
        }
        putchar('\n');
    }
}

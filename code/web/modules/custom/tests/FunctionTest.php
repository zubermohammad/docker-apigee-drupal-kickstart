<?php

use PHPUnit\Framework\TestCase;

class FunctionTest extends \PHPUnit\Framework\TestCase
{

    /*Testing a function using phpunit*/
    public function testAddReturnTheCorrectSum()
    {
        require "functions.php";
        $this->assertEquals(4,add(2, 2));
        $this->assertEquals(11,add(9, 2));
    }

    public function testAddDoesNotReturnTheIncorrectSum()
    {
        
        $this->assertNotEquals(6,add(2, 2));
    }
}
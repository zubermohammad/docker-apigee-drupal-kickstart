<?php

use PHPUnit\Framework\TestCase;

class ExampleTest extends \PHPUnit\Framework\TestCase
{
    public function testAddingTwoPlusTwoResultsinFour()
    {
        $this->assertEquals(4,2+2);
    }
}
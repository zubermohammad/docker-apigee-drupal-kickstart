<?php

use PHPUnit\Framework\Testcase;

class UserTest extends \PHPUnit\Framework\TestCase
{
    public function testReturnsFullName()
    {
        require "User.php";
        $user = new User;

        $user->first_name = 'Teresa';
        $user->surname = 'Blue';

        $this->assertEquals('Teresa Blue', $user->getfullName());
    }

    public function testFullNameIsEmptyByDefault()
    {
        $user = new User;

        $user->first_name = '';
        $user->surname = '';

        $this->assertEquals('', $user->getfullName());
    }
}
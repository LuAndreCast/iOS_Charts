//
//  Constants.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

@objc class Constants:NSObject
{
   static let shared = Constants()
    
   private let shinobiTrialLicenseKey =  "CimHEN1KDqpR5DCMjAxNjExMTdsdW9hbmRyZTI5QGdtYWlsLmNvbQ==NBAUCqOIkxaW+duxds6xqTKx/pdlJw7jESnzWRWPGcviUSElT8MKJR6huHPVgQuuolGotJb1SdJyieQrrlASSIVERXGpaWrd0RQ8EaLIZQnwgqfbF0napwhIX2FL0TSTbsIT7DqqjPe5r9Yz3Uq1zZVGW8Mk=AXR/y+mxbZFM+Bz4HYAHkrZ/ekxdI/4Aa6DClSrE4o73czce7pcia/eHXffSfX9gssIRwBWEPX9e+kKts4mY6zZWsReM+aaVF0BL6G9Vj2249wYEThll6JQdqaKda41AwAbZXwcssavcgnaHc3rxWNBjJDOk6Cd78fr/LwdW8q7gmlj4risUXPJV0h7d21jO1gzaaFCPlp5G8l05UUe2qe7rKbarpjoddMoXrpErC9j8Lm5Oj7XKbmciqAKap+71+9DGNE2sBC+sY4V/arvEthfhk52vzLe3kmSOsvg5q+DQG/W9WbgZTmlMdWHY2B2nbgm3yZB7jFCiXH/KfzyE1A==PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"
    
    public func getLicenseKey()->String
    {
        return shinobiTrialLicenseKey
    }
}//eoc



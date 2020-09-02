def fromRoman(romanNumber)
    numerals=["I","V","X","L","C","D","M"]
    finalVal = 0;
    for character in romanNumber.chars
        if !numerals.include? character
            raise TypeError
        end
    end
    mVal,i=charLoop("M",romanNumber,1000)
    cVal,i=charLoop("C",romanNumber,100,i)
    xVal,i=charLoop("X",romanNumber,10,i)
    iVal,i=charLoop("I",romanNumber,1,i)
    return finalVal = mVal+cVal+xVal+iVal
end

def charLoop(letterTier,romanNumber,val,i=0)
    endVal=0
    half = split(letterTier)
    nextCheck = getNext(letterTier)
    if romanNumber[i]!=letterTier
        if romanNumber[i]==half
            endVal=val*5
            i+=1
        else
            return endVal,i
        end
    end
    for character in romanNumber.chars[i..romanNumber.chars.length-1]
        if character==letterTier
            endVal+=val
            i+=1
        elsif character==half
            endVal+=val*3
            i+=1
            break
        elsif character==nextCheck
            endVal+=val*8
            i+=1
            break
        end
    end
    return endVal,i
end

def split(character)
    half=""
    if character=="C"
        half="D"
    elsif character=="X"
        half="L"
    elsif character=="I"
        half="V"
    end
    return half
end

def getNext(character)
    nextCheck=""
    if character=="C"
        nextCheck="M"
    elsif character=="X"
        nextCheck="C"
    elsif character=="I"
        nextCheck="X"
    end
    return nextCheck
end

def toRoman(arabicNumber)
    romanNumber=""
    if arabicNumber>3999 || arabicNumber <=0
        raise RangeError
    end
    numM=arabicNumber/1000.00
    numC=(arabicNumber-numM.floor()*1000.00)/100.00
    numX=(numC*100.00-numC.floor()*100.00) /10.00
    numI=numX*10.00-(numX.floor()*10.00)
    romanNumber="M"*numM.floor()
    updatedRomanNumber=romanNumber+splitCheck(numC,"C")
    updatedRomanNumber=updatedRomanNumber+splitCheck(numX,"X")
    updatedRomanNumber=updatedRomanNumber+splitCheck(numI,"I")
    return updatedRomanNumber
end

def splitCheck(numChar, character)
    numChar=numChar.floor()
    half=split(character)
    nextCheck=getNext(character)
    if numChar<4
        return character*numChar
    end
    if numChar==4
        return character+half
    elsif numChar==9
        return character+nextCheck
    else
        return half+character*(numChar-5)
    end
end
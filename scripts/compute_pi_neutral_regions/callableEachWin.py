import os
import sys

def callableEachWin (wins, callableSet):
	""" 
	This script tabulates the number of callable sites for each nonoverlapping window.
	Input 1: a list where each item in the list is a tuple of the form (start, end).
	Input 2: a set where each item is the callable position (1-based).
	Return: a dictionary where key is window in the form (start, end) and value is the count of callable sites.
	"""
	winsCallable = {}
	for eachWin in wins:
		callableCount = 0
		for eachPos in range(eachWin[0], eachWin[1]): # goal is to convert to 1-based
			if eachPos in callableSet:
				callableCount += 1
		winsCallable[eachWin] = callableCount
	return winsCallable



USE [kytechtalk]
GO

Select city, state, population, 
geometry.STX as latitude, geometry.STY as longitude  
from Cities


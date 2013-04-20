package gov.va.med.iss.mdebugger.vo;


import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.LinkedList;

public class StepResultsVO {
	
	private ResultReasonType resultReason;
	private boolean complete;
	private LinkedHashSet<VariableVO> variables;
	//location
	private String routineName;
	private int lineLocation;
	private String locationAsTag;
	private String nextCommand;
	private String lastCommand;
	//stack
	private LinkedList<StackVO> stack;
	//write
	private String writeLine;
	//watch variables
	private LinkedList<WatchVO> watchedVars;
	
	public StepResultsVO(ResultReasonType resultReason, boolean complete,
			LinkedHashSet<VariableVO> variables, String routineName,
			int lineLocation, String locationAsTag, String nextCommand,
			String lastCommand, LinkedList<StackVO> stack, String writeLine, LinkedList<WatchVO> watchedVars) {
		super();
		this.resultReason = resultReason;
		this.complete = complete;
		this.variables = variables;
		this.routineName = routineName;
		this.lineLocation = lineLocation;
		this.locationAsTag = locationAsTag;
		this.nextCommand = nextCommand;
		this.lastCommand = lastCommand;
		this.stack = stack;
		this.writeLine = writeLine;
		this.watchedVars = watchedVars;
	}
	
	public ResultReasonType getResultReason() {
		return resultReason;
	}

	public boolean isComplete() {
		return complete;
	}

	public Iterator<VariableVO> getVariables() {
		return variables.iterator();
	}

	public String getRoutineName() {
		return routineName;
	}

	public int getLineLocation() {
		return lineLocation;
	}
	
	public String getLocationAsTag() {
		return locationAsTag;
	}
	
	public String getNextCommnd() {
		return nextCommand;
	}
	
	public String getLastCommand() {
		return lastCommand;
	}

	public Iterator<StackVO> getStack() {
		return stack.iterator();
	}
	
	public String getWriteLine() {
		return writeLine;
	}
	
	public Iterator<WatchVO> getWatchedVars() {
		return watchedVars.iterator();
	}
	
	public enum ResultReasonType { //TODO: move to outer class
		START, STEP, BREAKPOINT, WATCHPOINT, WRITE, READ;
	}

}
